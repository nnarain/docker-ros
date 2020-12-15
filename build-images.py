import os
import yaml
import docker

from argparse import ArgumentParser

def main(args):
    image_info = load_image_info(args.file)

    if args.user:
        # if the user name was override, update the metadata
        image_info['meta']['user'] = args.user

    build_images(image_info)

def build_images(info):
    client = docker.from_env()

    user = info['meta']['user']

    for image in info['images']:
        name = image['name']
        dockerfile = image['dockerfile']
        platform = image.get('platform', 'linux/amd64')

        tag = f'{user}/{name}:latest'

        build_image(client, dockerfile, platform, tag)

def build_image(client, dockerfile, platform, tag):
    print(f'Building {dockerfile} as {tag}')
    client.images.build(path='.', dockerfile=dockerfile, platform=platform, tag=tag)

def image_name_from_dockerfile_path(path):
    # Use the path of the dockerfile as the image name
    # Convert path seperators to '-'
    return os.path.dirname(path).replace('/', '-')

def load_image_info(path):
    with open(path, 'r') as f:
        info = yaml.safe_load(f.read())
    return info

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument('-f', '--file', default='images.yaml', help='Image description file')
    parser.add_argument('-u', '--user', default=None, help='Username override')

    args = parser.parse_args()

    try:
        main(args)
    except Exception as e:
        print(f'An error occurred while building images: {e}')

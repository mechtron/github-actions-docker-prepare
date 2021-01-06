# github-actions-docker-prepare

Outputs the necesssary variables to build Docker images with [`docker/build-push-action@v2`](https://github.com/docker/build-push-action/tree/v2).

## Inputs

### `image`

The Docker image name. Example: `python/3.9-alpine`

## Outputs

### `tags`

The tag(s) to apply to the Docker image

### `version`

The version segment of the Docker image tag

### `created`

Date created string to tack on as an image label

## Example usage

```
- name: Login to Docker Hub
  if: github.event_name != 'pull_request'
  uses: docker/login-action@v1
  with:
    username: ${{ secrets.DOCKER_USERNAME }}
    password: ${{ secrets.DOCKER_TOKEN }}
- name: Set up Docker Buildx
  uses: docker/setup-buildx-action@v1
- name: Prepare for Docker image build
  id: prep_image
  uses: mechtron/github-actions-docker-prepare@1.0.0
  with:
    image: mechtron/posts-api
- name: Build API Docker image
  uses: docker/build-push-action@v2
  with:
    context: .
    file: Dockerfile
    tags: ${{ steps.prep_image.outputs.tags }}
    labels: |
      org.opencontainers.image.source=${{ github.event.repository.html_url }}
      org.opencontainers.image.created=${{ steps.prep_image.outputs.created }}
      org.opencontainers.image.revision=${{ github.sha }}
```

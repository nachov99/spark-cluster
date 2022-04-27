# Spark - cluster

## About
Deploy Spark and Jupyter on Docker.

## Requirements
 * Docker

## Important
You can only run one project at a time.

## Customization
In `docker-compose.yml` you can customize the number of workers, their memory and cpu cores. Also, if you want to change anything in any file, feel free to do it.

## How to run it?
1. Build images
```
sh build_images.sh
```
2. Build containers \
If you want to use a custom project name:
```
sh build_containers.sh [PROJECT_NAME]
```
else:
```
sh build_containers.sh
```

## Issues

| Issues               |To Do          |In progress    |Testing		   |Done		   |
| -------------------- |:-------------:|:-------------:|:-------------:|:-------------:|
| Automatic git repo   |               | X             |               |               |
| Apache YARN          | X             |               |               |               |
| Admin panel          | X             |               |               |               |

## Future updates
* Automatic git repo: Automatic creation of a github repository.
* Apache YARN: Dynamic containers management.
* Admin panel: Simple website to create multiple projects running at the same time (Team management, Schedule tasks?).

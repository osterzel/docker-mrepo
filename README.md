# MREPO

Mirror and Serve Package Repos

## Quick start

`make run_web` 

This will generate and update the repo in a folder called repo in the current directory, it will then
start a webserver on port 8090 on the docker host 

## Mirror Repos

`docker run -it --rm mrepo`

Mirror Repos and start nginx to serve them over port 80

`docker run -p 80:80 -it -e WEB=True mrepo`

Mirror Repos onto a local system - This allows your repos to persist after the container had gone to the bit bucket.

`docker run -it --rm -v /localfolder/repo:/mrepo mrepo `

Mirror just one repo (for any dist it exists in)
`docker run -it --rm -v -e REPO=epel mrepo`

Mirror repose and freeze/lock the CentOS repo
`docker run -it --rm -e FROZEN=centos6-x86_64 -v /localfolder/repo:/mrepo mrepo`


Run the container but overide the default repo config file. Use this to define the repos you want for your site

`docker run -it --rm -v /mrepo/config/repos.conf:/etc/mrepo.conf.d/repos.conf mrepo`


##  Environment Variables

- WEB - defaults to the string `False`, set to `True` to start the nginx webserver and keep the container active serving the mirror after it has been created/updated
- DIST - Name of the dist to update, defaults to empty, so all dists are updated.
- VERBOSE - defaults to the string `False`, set to anything to crank up verbosity of mrepo so you can see what its doing
- UPDATE - defaults to the string `True` and causes mrepo to run with the -guv argument.  It can be passed as *anything* other then true if you want to run this container, but do *not* want to updated your configured mirrors.
- FROZEN - defaults to empty,  This variable takes a single argument, which *must* be the format "$dist-$arch" and must match the directory in the mrepo srcdir for the repo you want to freeze/lock.  You must also have a repo definition in your distro config called 'frozen'

>For example, if you wanted to lock a CentOS repo that was configured like this:
>
>```
>[centos6.6]
>name = CentOS $release ($arch)
>release = 6.6
>arch = x86_64
>os = http://archive.kernel.org/centos-vault/$release/os/$arch/
>centosplus = http://archive.kernel.org/centos-vault/$release/centosplus/$arch/
>updates = http://archive.kernel.org/centos-vault/$release/updates/$arch/
>extras = http://archive.kernel.org/centos-vault/$release/extras/$arch/
>frozen = file:///mrepo/$dist-$arch/frozen
>```
>The value of the frozen variable would be `centos6-x86_64`
>
>**FROZEN** Should only be passed *once* for each repo you want to freeze. It locks the repo at a particular point in time, and passing the FROZEN variable multiple times would updated the frozen repo to the most current version of the packages.

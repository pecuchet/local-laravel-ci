# Continuously integrate & deploy Laravel from your own machine

## Usage
```
make install                            # Symlinks local githooks
make feature new-service                # You are now on the feature-new-service branch        
                                        # Make some code changes
git commit -am "Added new service"      # The CI tools will run before the commit
git push -u origin feature-new-service  # Before the push to origin changes will be synced with configured staging server
```

## To do
- extend `make install` to install composer tools
- find way to install in existing/new Laravel app
- support [skip ci]
- git re-add files if CS changes
- pre-push deploy is also triggered when doing `git push origin --delete feature-ci`
    - ie. rsync to production !
        - use push target instead of current branch
- what if you do not want to push a feature branch to staging?
    - eg a feature which is not ready, but you want it in your vcs

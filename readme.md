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
- 

## Default Rails App for new projects

[View the Demo app on Heroku here](https://rails4-defaultapp.herokuapp.com/)
Login and test adding all the social accounts.

# Setup App

#### Copy and paste this into your bash file of choice.
##### Example `~/.bash_profile` or `~/.bashrc`
Then reload your terminal and run `setupApp` in your project directory

```bash
setupApp() {
  if [ -e `heroku info -s | grep web_url` ]; then
    echo -n "Name for your new Heroku app: "
    read appName
    if [ ${#appName} -eq 0 ]; then
      echo "No app name given"
      read -p "Do you want to try again? [y/n] " -n 1 -r
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        printf '\n%s' "Exiting..."
        kill -INT $$
      fi
    fi
    (heroku apps:create "${appName}")
  fi

  printf '\n%s\n' "Adding Heroku addons"
  (heroku addons:create heroku-postgresql)
  (heroku addons:create memcachier)
  (heroku addons:create newrelic)
  (heroku addons:create pgbackups)
  (heroku addons:create redistogo)
  (heroku addons:create sendgrid)

  printf '\n%s\n' "Adding Heroku ENV vars"
  (heroku config:add DEVISE_SECRET_KEY="$(bundle exec rake secret)")
  (heroku config:add DEVISE_PEPPER="$(bundle exec rake secret)")
  (heroku config:add SECRET_KEY_BASE="$(bundle exec rake secret)")
  (heroku config:set REDIS_URL=`heroku config:get REDISTOGO_URL`)
  (heroku config:add MAIL_HOST=`heroku info -s | grep web_url | cut -d= -f2`)
}
```

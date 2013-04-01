Rails-4-ToDo-App
================

Just trying out Rails 4 + jQuery 2 + Giphy API

So, I decided to use Ubuntu 12.10 and test Ruby Mine IDE (JetBrains) for development. I had to install Oracle's JDK from [http://www.devsniper.com/ubuntu-12-04-install-sun-jdk-6-7/](http://www.devsniper.com/ubuntu-12-04-install-sun-jdk-6-7/).

Then I installed Ruby 2.0.0 using RVM following the instructions on [http://www.ruby-lang.org/en/downloads/](http://www.ruby-lang.org/en/downloads/).

After that I installed Rails 4.0.0.beta1 (latest version) by doing `gem install rails --version 4.0.0.beta1 --no-ri --no-rdoc`.

Create a folder named `todo`, clone the repo in it, then `rails new <path to the 'todo' folder>`.

Do not forget about the [Rails insecure defaults](http://blog.codeclimate.com/blog/2013/03/27/rails-insecure-defaults/) and fix the `secret_token` with similar solution to [https://github.com/hotsh/rstat.us/blob/master/config/initializers/secret_token.rb](https://github.com/hotsh/rstat.us/blob/master/config/initializers/secret_token.rb).

Then commit and push.

I had to add the following `[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"` on the bottom of my .bashrc (.zshrc) otherwise calling `rails` from a new terminal window did not work.

Install [bundler](http://gembundler.com/) <del>and try to make `haml` and `tilt` operational</del>.

Install <del>`rails-boilerplate` for</del> [html5boilerplate](http://html5boilerplate.com/) miracles. 

Add `jquery-rails` gem to the Gemfile to add cheap support for CSRF tokens and better jQuery integration.

Add `rest-in-place` gem to allow in-place editing of fields.

Last step is to deploy to heroku. Heroku is a tiny bitch sometimes. Here what the key points were in my case.

Start following the simple tutorial for rails deployment on heroku and by the time you are about to push to heroku set a SECRET_TOKEN on your stack `heroku config:add SECRET_TOKEN=<secret token>`. The token can be generated by running `rake secret`.

Then follow the instructions how to [prebuild your static assets](https://devcenter.heroku.com/articles/rails-asset-pipeline).

After the static assets are done, create a file `public/assets/manifest.yml`, because Rails 4 will not create it for you, but heroku is using it as indicator whether to prebuild your assets or not. Heroku's deployment will fail if it tries prebuilding the assets :-/



Check out the app here: [http://todo-rails4.herokuapp.com/](http://todo-rails4.herokuapp.com/)
----------------------------------------------------------------------------------------------

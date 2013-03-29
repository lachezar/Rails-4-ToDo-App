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


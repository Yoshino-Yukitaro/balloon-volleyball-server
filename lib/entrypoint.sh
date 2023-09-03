#!/bin/bash
RAILS_ENV=production rails db:migrate
RAILS_ENV=production rails db:seed
RAILS_ENV=production rails server -b 0.0.0.0
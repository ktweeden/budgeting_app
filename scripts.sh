#!/usr/bin/env bash

if [[ -z $DATABASE_URL ]]; then
  DATABASE_URL=budget
fi

psql -d $DATABASE_URL -f db/budget.sql
ruby db/seeds.rb

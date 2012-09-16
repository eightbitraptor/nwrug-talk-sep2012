Given /^I have a running Ubuntu VM$/ do
  vagrant_cli_command('up')
end

Given /^I have puppet installed$/ do
  run_vagrant_command('which puppet > /dev/null')
end

Then /^I should have nginx installed$/ do
  run_vagrant_command('which nginx > /dev/null')
end

Then /^nginx should be running$/ do
  run_vagrant_command('sudo service nginx status')
end

Then /^I should have mysql installed$/ do
  run_vagrant_command('which mysql > /dev/null')
end

Then /^mysql should be running$/ do
  run_vagrant_command('sudo service mysql status')
end


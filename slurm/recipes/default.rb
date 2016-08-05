#
# Cookbook Name:: gia
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "net::hostname"                                                  
#include_recipe "mysql"                                                     
#include_recipe "slurm::munge"                                                     
#include_recipe "slurm::database"                                                   
#include_recipe "slurm::controller" 
#include_recipe "slurm::worker"

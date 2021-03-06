#Copyright 2017 Cisco Systems, Inc.
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#    http://www.apache.org/licenses/LICENSE-2.0
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

$:.unshift *Dir[::File.expand_path('../../files/default/vendor/gems/**/lib',__FILE__)]

=begin
DOCUMENTATION
---------------------
Resource Name: cisco_imc_password_expiry_config
short_description:
Configures the password expiration policy for local users on a Cisco IMC server.
version_added: "0.9.1.0"
description:
    - Configures the password expiration policy for local users on a Cisco IMC server.
options:
    password_expiry_duration:
        description: Specifies in days when the password will expire when password expiry is enabled.
        choices: [0-3650]
        default:365
        required: false
    password_history:
        description: Tracks password change history. Specifies in number of instances, the new password entered should not have been used in the past.
        choices: [0-5]
        default: 0
        required: false
    password_notification_period:
        description: Specifies the number of days the user will be notified before password expiry.
        choices: [0-15]
        default: 15
        required: false
    password_grace_period:
        description: Specifies the number of days the old password will still be valid after the password expiry.
        choices: [0-5]
        default: 0
        required: false
requirements: ['imcsdk']
author: "Amit Mandal(amimanda@cisco.com)"
=end

=begin
RECIPE EXAMPLES
- name: set password policy
    cisco_imc_password_expiry_config 'Password_expiry_config' do
        ipaddress '10.105.219.15'
        auth_data "imc_account"
        password_expiry_duration 365
        password_history 1
        password_notification_period 15
        password_grace_period 15
        action :set
    end
=end


require_relative './cisco_imc_utils'
require 'ImcSdk/apis/admin/user'

resource_name :cisco_imc_password_expiry_config

provides :cisco_imc_password_expiry_config

    property :ipaddress, String, required: true
    property :auth_data, String, required: true # data bag item name under cisco_imc_accounts data bag
    property :password_expiry_duration, String, default: "365"
    property :password_history, String, default: "0"
    property :password_notification_period, String, default: "15"
    property :password_grace_period, String, default: "0"


    load_current_value do |property|

        account = data_bag_item(node[:databag][:name], property.auth_data)

        #Login to Cisco IMC
        imc_connection = ImcConnection.new(property.ipaddress, account)
        handle = imc_connection.login()

        begin
            props = {}
            #if property_is_set?(:password_expiry_duration)
                props[:password_expiry_duration] = property.password_expiry_duration
            #end
            #f property_is_set?(:password_history)
                props[:password_history] = property.password_history
            #end
            #if property_is_set?(:password_notification_period)
                props[:password_notification_period] = property.password_notification_period
            #end
            #if property_is_set?(:password_grace_period)
                props[:password_grace_period] = property.password_grace_period
            #end

            match, mo = password_expiration_exists(handle: handle, **props)
            
            if !mo.nil?
                password_expiry_duration mo.password_expiry_duration
                password_history mo.password_history
                password_notification_period mo.password_notification_period
                password_grace_period mo.password_grace_period
            elsif !match
                password_expiry_duration nil
                password_history nil
                password_notification_period nil
                password_grace_period nil
            end
        rescue => exception
            Chef::Log.error("Exception Occurred: #{exception.message}")
            Chef::Log.error("Exception Backtrace: #{exception.backtrace.join("\n\t")}")
        ensure
            imc_connection.logout()  
        end
    end

    action :set do
        account = data_bag_item(node[:databag][:name], auth_data)

        #Login to Cisco IMC
        imc_connection = ImcConnection.new(ipaddress, account)
        handle = imc_connection.login()
        converge = false
        begin
            if handle.nil?
                raise "handle is nil"
            end
            converge_if_changed :password_expiry_duration do
                converge = true
            end
            converge_if_changed :password_history do
                converge = true
            end
            converge_if_changed :password_notification_period do
                converge = true
            end
            converge_if_changed :password_grace_period do
                converge = true
            end                
            if converge
                password_expiration_set(handle: handle,
                                        password_expiry_duration: password_expiry_duration,
                                        password_history: password_history,
                                        password_notification_period: password_notification_period,
                                        password_grace_period: password_grace_period)
            end
        rescue => exception
            Chef::Log.error("Exception Occurred: #{exception.message}")
            Chef::Log.error("Exception Backtrace: #{exception.backtrace.join("\n\t")}")
        ensure
            imc_connection.logout()   
        end
    end

    action_class do
        def whyrun_supported?
            true
        end
    end
    
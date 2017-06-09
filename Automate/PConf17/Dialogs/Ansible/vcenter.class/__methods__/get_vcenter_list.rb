#
#            Automate Method
#
# Copyright (C) 2016, Christian Jung
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

$evm.log("info", "EVM Automate Method Started")

# Dump all of root's attributes to the log
$evm.root.attributes.sort.each { |k, v| $evm.log("info", "Root:<$evm.root> Attribute - #{k}: #{v}")}

providers={}

# get all providers
$evm.vmdb('ext_management_system').all.each do |provider|
    $evm.log("info", "All about provider: Name: #{provider.name}, Type: #{provider.type}, Hostname: #{provider.hostname}")

    if provider.type == "ManageIQ::Providers::Vmware::InfraManager" then
        providers[provider.hostname]=provider.name
        $evm.log("info", "Adding #{provider.name} with hostname #{provider.hostname} to the dialog ist")
    end
end

dialog_field = $evm.object
# sort_by: value / description / none
dialog_field["sort_by"] = "description"
# sort_order: ascending / descending
dialog_field["sort_order"] = "ascending"
# data_type: string / integer
dialog_field["data_type"] = "string" 
# required: true / false
dialog_field["required"] = "true"

dialog_field["values"]=providers

#
# Exit method
#
$evm.log("info", "EVM Automate Method Ended")
exit MIQ_OK

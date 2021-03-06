#  Copyright 2020 ThoughtWorks, Inc.
#  
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as
#  published by the Free Software Foundation, either version 3 of the
#  License, or (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.
#  
#  You should have received a copy of the GNU Affero General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/agpl-3.0.txt>.

require File.join(File.dirname(__FILE__), '/../../config/boot')
require 'tempfile'
require 'net/http'
require 'active_record'
require 'fileutils'
require File.expand_path(File.dirname(__FILE__) + "/mingle_helpers/multipart_post")

# add all "vendorified" gems

url = URI.parse(ARGV[0])
uploaded_data = MultipartPost.uploaded_file(ARGV[1])
response = MultipartPost.multipart_post(url, :file => uploaded_data)

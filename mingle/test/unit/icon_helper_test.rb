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

require File.expand_path(File.dirname(__FILE__) + '/../unit_test_helper')

class IconHelperTest < ActiveSupport::TestCase
  include IconHelper, FileColumnHelper, ApplicationHelper

  def setup
    @project = first_project
    login_as_member
    @project.activate
  end

  def test_icon_for_returns_image_tag_for_current_icon_if_one_is_set
    f = uploaded_file(icon_file_path("icon.png"))
    @project.update_attributes :icon => f
    assert_match /\/project\/icon\/.*\/icon\.png/,  icon_for(@project).first
  end

  def test_icon_for_returns_default_icon_if_no_icon_set_for_project
    assert_equal 'default-project-icon.png',  icon_for(@project).first
  end

  private
  def image_tag(*args)
    args
  end
end

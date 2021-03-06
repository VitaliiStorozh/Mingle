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

class ProgramFeedsController < PlannerApplicationController
  allow :get_access_for => [:events, :index]

  skip_before_filter :check_license, :only => [:events]

  def index
    render :template => "errors/not_found", :status => 404, :layout => 'error'
  end

  def events
    cache = FeedsCache.new(Feeds.new(@program, params[:page]), MingleConfiguration.site_url)
    cache.write unless cache.cached?
    expires_now
    render :text => cache.get, :content_type => 'application/atom+xml'
  rescue => e
    ActiveRecord::Base.logger.error { e }
    render :xml => e.xml_message, :status => 500
  end
end

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

class CreateComputeAggregateRequestTable < ActiveRecord::Migration
  def self.up
    create_table :compute_aggregate_requests, :force => true do |t|
      t.column "card_id",   :integer, :null => false
      t.column "aggregate_property_definition_id", :integer, :null => false
      t.column "project_id",   :integer, :null => false
    end
  end

  def self.down
    drop_table :compute_aggregate_requests
  end
end

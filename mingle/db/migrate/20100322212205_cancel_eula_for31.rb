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

class CancelEulaFor31 < ActiveRecord::Migration
  def self.up
    unless ActiveRecord::Base.table_name_prefix.starts_with?('mi_')  # need a better way to make this check
      update_sql = SqlHelper.sanitize_sql("UPDATE licenses SET eula_accepted = ?", false)
      ActiveRecord::Base.connection.execute(update_sql)
    end
  end

  def self.down
  end
end

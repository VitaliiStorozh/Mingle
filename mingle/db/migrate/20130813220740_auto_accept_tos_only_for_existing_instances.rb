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

class AutoAcceptTosOnlyForExistingInstances < ActiveRecord::Migration
  def self.up
    self.drop_existing_saas_tos

    if User.count > 0
      execute sanitize_sql(<<SQL, true, Time.now, Time.now)
      INSERT INTO #{safe_table_name('saas_tos')} (id, user_email, accepted, created_at, updated_at) VALUES (1, 'auto-accepted@example.com', ?, ?, ?)
SQL
    end
  end

  def self.down
    self.drop_existing_saas_tos
  end

  private

  def self.drop_existing_saas_tos
    execute sanitize_sql(<<SQL)
      DELETE FROM #{safe_table_name('saas_tos')}
SQL
  end
end

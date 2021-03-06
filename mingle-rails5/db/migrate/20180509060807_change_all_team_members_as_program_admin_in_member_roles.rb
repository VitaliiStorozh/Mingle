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

class ChangeAllTeamMembersAsProgramAdminInMemberRoles < ActiveRecord::Migration[5.0]
  class << self
    alias_method :c, :quote_column_name
    alias_method :t, :safe_table_name

    def up
      program_ids = select_values sanitize_sql("SELECT #{c('id')} FROM #{t('deliverables')} where #{c('type')} = 'Program'")
      program_ids.each do |program_id|
        execute sanitize_sql("UPDATE #{t('member_roles')} SET #{c('permission')} = 'program_admin'
                              WHERE #{c('deliverable_id')} = #{program_id}")
      end
    end

    def down
      program_ids = select_values sanitize_sql("SELECT #{c('id')} FROM #{t('deliverables')} where #{c('type')} = 'Program'")
      program_ids.each do |program_id|
        execute sanitize_sql("UPDATE #{t('member_roles')} SET #{c('permission')} = 'full_member'
                             WHERE #{c('deliverable_id')} = #{program_id}")
      end

    end

  end
end

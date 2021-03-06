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

require 'test/unit'
require 'rscm/path_converter'
require 'rscm'
require 'rscm/generic_scm_tests'

module RSCM

  class Cvs
    # Convenience factory method used in testing
    def Cvs.local(cvsroot_dir, mod)
      cvsroot_dir = PathConverter.filepath_to_nativepath(cvsroot_dir, true)
      Cvs.new(":local:#{cvsroot_dir}", mod)
    end
  end
  
  class CvsTest < Test::Unit::TestCase
    
    include GenericSCMTests
    include ApplyLabelTest
    
    def create_scm(repository_root_dir, path)
      Cvs.local(repository_root_dir, path)
    end

    def test_should_fail_on_bad_command
      assert_raise(RuntimeError) do
        Cvs.new("").create
      end
    end
    
  end
end

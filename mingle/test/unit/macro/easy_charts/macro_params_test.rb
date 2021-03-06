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

require File.expand_path(File.dirname(__FILE__) + '../../../../unit_test_helper')

class MacroParamsTest < ActiveSupport::TestCase
  def setup

  end

  test 'extract_should_throw_exception_if_macro_type_not_given' do
    assert_raise_with_message(EasyCharts::MacroEditorNotSupported, ' not supported for edit') do
      EasyCharts::MacroParams.extract('')
    end
  end

  test 'extract_should_throw_exception_if_chart_editing_not_supported_for_given_macro_type' do
    assert_raise_with_message(EasyCharts::MacroEditorNotSupported, 'random-chart not supported for edit') do
      MingleConfiguration.overridden_to(easy_charts_macro_editor_enabled_for: 'pie-chart') do
        EasyCharts::MacroParams.extract(%Q{
        {{
          random-chart
            data: 'Select Size, count(*) Where Type = "Card" AND Size < 10 AND TAGGED WITH "blah"'
        }}
        })
      end
    end
  end

  test 'extract_should_throw_exception_if_chart_editing_not_enabled_for_given_macro_type' do
    assert_raise_with_message(EasyCharts::MacroEditorNotSupported, 'pie-chart not supported for edit') do
      MingleConfiguration.overridden_to(easy_charts_macro_editor_enabled_for: '') do
        EasyCharts::MacroParams.extract(%Q{
        {{
          pie-chart
            data: 'Select Size, count(*) Where Type = "Card" AND Size < 10 AND TAGGED WITH "blah"'
        }}
        })
      end
    end
  end

  test 'extract_should_call_specifi_macro_class_for_extraction_of_params' do
    EasyCharts::PieChartMacroParams.expects(:from)
        .with({'data' => 'Select Size, count(*) Where Type = "Card" AND Size < 10 AND TAGGED WITH "blah"',
               'chart-size' => 'large', 'title' => 'Awesome Chart'})
        .returns(:ok)
    MingleConfiguration.overridden_to(easy_charts_macro_editor_enabled_for: 'pie-chart') do
      EasyCharts::MacroParams.extract(%Q{
      {{
        pie-chart
          data: 'Select Size, count(*) Where Type = "Card" AND Size < 10 AND TAGGED WITH "blah"'
          chart-size: large
          title: 'Awesome Chart'
      }}
      })
    end
  end


end

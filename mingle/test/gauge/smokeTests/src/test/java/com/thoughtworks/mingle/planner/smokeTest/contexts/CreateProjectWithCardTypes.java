/*
*  Copyright 2020 ThoughtWorks, Inc.
*  
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU Affero General Public License as
*  published by the Free Software Foundation, either version 3 of the
*  License, or (at your option) any later version.
*  
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU Affero General Public License for more details.
*  
*  You should have received a copy of the GNU Affero General Public License
*  along with this program.  If not, see <https://www.gnu.org/licenses/agpl-3.0.txt>.
*/

package com.thoughtworks.mingle.planner.smokeTest.contexts;

import com.thoughtworks.mingle.planner.smokeTest.util.JRubyScriptRunner;
import com.thoughtworks.mingle.planner.smokeTest.util.JRubyScriptRunner.ScriptBuilder;
import com.thoughtworks.mingle.planner.smokeTest.util.JRubyScriptRunner.ScriptWriter;

public class CreateProjectWithCardTypes {

    private final JRubyScriptRunner scriptRunner;

    public CreateProjectWithCardTypes(JRubyScriptRunner jRubyScriptRunner) {
        this.scriptRunner = jRubyScriptRunner;
    }

    public void setUp(final String projectNames, final String cardTypes) throws Exception {
        this.scriptRunner.executeWithTestHelpers(new ScriptBuilder() {
            public void build(ScriptWriter scriptWriter) {
                for (String projectName : projectNames.split(",")) {
                    scriptWriter.printfln("create_project(:name => '%s').with_active_project do |project|", projectName);
                    for (String cardType : cardTypes.split(",")) {
                        scriptWriter.printfln("setup_card_type(project, '%s')", cardType);
                    }
                }
                scriptWriter.printfln("end");
            }
        });
    }

    public void tearDown(String projectNames, String cardTypes) throws Exception {}

}

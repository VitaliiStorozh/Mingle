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

// JUnit Assert framework can be used for verification

import net.sf.sahi.client.Browser;

import com.thoughtworks.mingle.planner.administration.BackgroundTasks;
import com.thoughtworks.mingle.planner.smokeTest.util.Assertions;
import com.thoughtworks.mingle.planner.smokeTest.util.JRubyScriptRunner;

public class FakeNow extends Assertions {

    private final JRubyScriptRunner scriptRunner;

    public FakeNow(Browser browser, JRubyScriptRunner jRubyScriptRunner) {
        super(browser);
        this.scriptRunner = jRubyScriptRunner;

    }

    @com.thoughtworks.gauge.Step("FakeNow <year> <month> <day> - setup")
	public void setUp(int year, int month, int day) throws Exception {
        new BackgroundTasks(browser, scriptRunner).fakeDateAs(year, month, day);
    }

    @com.thoughtworks.gauge.Step("FakeNow <year> <month> <day> - teardown")
	public void tearDown(int year, int month, int day) throws Exception {
        new BackgroundTasks(browser, scriptRunner).resetToCurrentDate();
    }
}

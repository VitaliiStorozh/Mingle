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

import net.sf.sahi.client.Browser;

import com.thoughtworks.mingle.planner.smokeTest.util.Constants;

public class EnableRealLicenseDecryption extends Constants {

    private final Browser browser;

    public EnableRealLicenseDecryption(Browser browser) {
        this.browser = browser;
    }

    @com.thoughtworks.gauge.Step("Enable real license decryption - setup")
	public void setUp() throws Exception {
        this.browser.navigateTo(this.getPlannerBaseUrl() + "/_class_method_call?class=LicenseDecrypt&method=enable_license_decrypt");
    }

    @com.thoughtworks.gauge.Step("Enable real license decryption - teardown")
	public void tearDown() throws Exception {
        this.browser.navigateTo(this.getPlannerBaseUrl() + "/_class_method_call?class=LicenseDecrypt&method=disable_license_decrypt");
    }

}

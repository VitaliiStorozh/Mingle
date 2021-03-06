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
export default function createProgramProperties(services, data) {
  return {
    state: {
      properties: data.properties
    },

    mutations: {
      updateProperties(state, property) {
        state.properties.push(property);
      }
    },

    actions:{
      createProperty(context, property){
        return new Promise((resolver) =>{
          services.programProperties.create(property).then((result) => {
            if(result.success) {
              this.commit('updateProperties', result.property);
              resolver(result);
            }
            else{
              resolver({success: false, message: {type:'error', text: result.error}});
            }
          });
        });
      }
    }
  }
}
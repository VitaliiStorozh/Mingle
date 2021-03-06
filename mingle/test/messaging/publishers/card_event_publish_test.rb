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

require File.expand_path(File.dirname(__FILE__) + '/../../unit_test_helper')
require File.expand_path(File.dirname(__FILE__) + '/../messaging_test_helper')

# Tags: messaging, cards, indexing
class CardEventPublishTest < ActiveSupport::TestCase
  include MessagingTestHelper
  
  def setup
    route(:from => CardEventPublisher::QUEUE, :to => TEST_QUEUE)
  end

  def test_should_publish_event_onto_card_queue_on_card_create
    login_as_member
    with_first_project do |project|
      new_card = project.cards.create!(:name => 'Brand new card', :card_type_name => 'Card')
      assert_message_in_queue new_card.message
    end
  end
  
  def test_should_publish_event_onto_card_queue_on_card_update
    login_as_member
    with_first_project do |project|
      card = project.cards.first
      assert_not_nil card
      card.update_attribute :name, 'new card name'
      
      assert_message_in_queue card.message
    end
  end
end

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

require File.expand_path(File.dirname(__FILE__) + '/../../test_helper')

class DatabaseSchemaTest < ActiveSupport::TestCase

  class FakeSchema
    attr_reader :methods_called
    def initialize
      @methods_called = []
    end

    def name
      'schema name'
    end

    def method_missing(m, *args, &block)
      @methods_called << {:method => m.to_s}
      block.call if block_given?
    end
  end

  def setup
    @schema = FakeSchema.new
  end

  def db_url
    "jdbc:oracle:thin:@fmtstdmngdb09.thoughtworks.com:1521:dummy"
  end

  def test_should_switch_connection_pool_when_do_create
    ds = Multitenancy::DatabaseSchema.new(db_url, @schema)
    Multitenancy::CONNECTION_MANAGER.expects(:with_connection).with(db_url).once.yields
    ds.create
    assert_equal [{:method => 'create'}], @schema.methods_called
  end

  def test_should_switch_connection_pool_when_do_exists?
    ds = Multitenancy::DatabaseSchema.new(db_url, @schema)
    Multitenancy::CONNECTION_MANAGER.expects(:with_connection).with(db_url).once.yields
    ds.exists?
    assert_equal [{:method => 'exists?'}], @schema.methods_called
  end

  def test_should_switch_connection_pool_when_do_delete
    ds = Multitenancy::DatabaseSchema.new(db_url, @schema)
    Multitenancy::CONNECTION_MANAGER.expects(:with_connection).with(db_url).once.yields
    ds.delete
    assert_equal [{:method => 'delete'}], @schema.methods_called
  end

  def test_should_switch_connection_pool_when_do_ensure
    ds = Multitenancy::DatabaseSchema.new(db_url, @schema)
    Multitenancy::CONNECTION_MANAGER.expects(:with_connection).with(db_url).once.yields
    ds.ensure { x = 10 }
    assert_equal [{:method => 'ensure'}], @schema.methods_called
  end

  def test_should_use_default_config_if_db_url_is_nil
    ds = Multitenancy::DatabaseSchema.new(nil, @schema)
    assert_equal Multitenancy::DEFAULT_DB_URL, ds.db_url
  end

  def test_should_use_default_config_if_db_url_is_empty_string
    ds = Multitenancy::DatabaseSchema.new('', @schema)
    assert_equal Multitenancy::DEFAULT_DB_URL, ds.db_url
  end

  def test_should_use_default_config_if_db_url_is_invalid
    ds = Multitenancy::DatabaseSchema.new('abcd.aws.comsdfsd.com', @schema)
    assert_equal Multitenancy::DEFAULT_DB_URL, ds.db_url
  end

  def test_name_should_be_schema_name
    ds = Multitenancy::DatabaseSchema.new(nil, @schema)
    assert_equal @schema.name, ds.name
  end

  def test_fake_tenant
    ds = Multitenancy::DatabaseSchema.new(db_url, @schema)
    t = ds.fake_tenant
    assert_equal ds.name, t.name
    assert_equal ds.name.upcase, t.schema_name
    assert_equal(db_url, t.db_config[:url])
  end
end

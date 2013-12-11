require 'test_helper'

class Elasticsearch::Model::ResponseTest < Test::Unit::TestCase
  context "Response" do
    class OriginClass; end

    RESPONSE = { 'took' => '5', 'timed_out' => false, '_shards' => {'one' => 'OK'}, 'hits' => { 'hits' => [] } }

    should "access klass, response, took, timed_out, shards" do
      response = Elasticsearch::Model::Response::Response.new OriginClass, RESPONSE

      assert_equal OriginClass, response.klass
      assert_equal RESPONSE, response.response
      assert_equal '5',      response.took
      assert_equal false,    response.timed_out
      assert_equal 'OK',     response.shards.one
    end

    should "initialize and access the results" do
      response = Elasticsearch::Model::Response::Response.new OriginClass, RESPONSE
      assert_instance_of Elasticsearch::Model::Response::Results, response.results
    end

    should "initialize and access the records" do
      response = Elasticsearch::Model::Response::Response.new OriginClass, RESPONSE
      assert_instance_of Elasticsearch::Model::Response::Records, response.records
    end

    should "delegate Enumerable methods to results" do
      response = Elasticsearch::Model::Response::Response.new OriginClass, RESPONSE

      assert response.empty?
    end
  end
end
require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestClusters < MiniTest::Unit::TestCase
  def test_list_clusters
    response = xplenty.clusters

    data = File.read("#{File.dirname(__FILE__)}/../lib/xplenty/api/mock/cache/clusters.json")

    assert_equal(200, response.status)
    assert_equal(Xplenty::API::OkJson.decode(data), response.body)
  end

  def test_get_cluster_info
    with_cluster({:type => 'sandbox', :nodes => 1}) do |cluster|
      response = xplenty.get_cluster_info(cluster['id'])
      assert_equal response.status, 200
      assert_equal response.body['id'], cluster['id']
    end
  end

  def test_terminate_cluster
    with_cluster({:type => 'sandbox', :nodes => 1}) do |cluster|
      response = xplenty.terminate_cluster(cluster['id'])
      assert_equal response.status, 200
    end
  end
end

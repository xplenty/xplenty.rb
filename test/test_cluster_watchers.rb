require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestClusterWatchers < MiniTest::Unit::TestCase
  def test_watch_cluster
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      response = xplenty.watch_cluster(cluster['id'])
      assert_equal(200, response.status)
    end
  end

  def test_stop_watching_job
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      xplenty.watch_cluster(cluster['id'])
      response = xplenty.stop_watching_cluster(cluster['id'])
      assert_equal(200, response.status)
    end
  end

  def test_list_job_watchers
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      xplenty.watch_cluster(cluster['id'])
      response = xplenty.cluster_watchers(cluster['id'])
      assert_equal(200, response.status)
    end
  end

end

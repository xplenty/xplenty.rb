require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestJobWatchers < MiniTest::Unit::TestCase
  def test_watch_job
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      job = xplenty.run_job(cluster['id'], 682).body
      response = xplenty.watch_job(job['id'])
      assert_equal(200, response.status)
    end
  end

  def test_stop_watching_job
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      job = xplenty.run_job(cluster['id'], 682).body
      xplenty.watch_job(job['id'])
      response = xplenty.stop_watching_job(job['id'])
      assert_equal(200, response.status)
    end
  end

  def test_list_job_watchers
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      job = xplenty.run_job(cluster['id'], 682).body
      xplenty.watch_job(job['id'])
      response = xplenty.job_watchers(job['id'])
      assert_equal(200, response.status)
    end
  end

end

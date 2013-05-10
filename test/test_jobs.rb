require File.expand_path("#{File.dirname(__FILE__)}/test_helper")

class TestJobs < MiniTest::Unit::TestCase

  def test_list_jobs
    response = xplenty.jobs
    assert_equal(200, response.status)
    assert_equal(Array, response.body.class)
  end

  def test_run_job
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      response = xplenty.run_job(cluster['id'], 682)
      assert_equal(201, response.status)
    end
  end

  def test_get_job_info
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      job = xplenty.run_job(cluster['id'], 682).body
      response = xplenty.get_job_info(job['id'])
      assert_equal(200, response.status)
    end
  end

  def test_terminate_job
    with_cluster({'type' => 'sandbox', 'nodes' => 1}) do |cluster|
      job = xplenty.run_job(cluster['id'], 682).body
      response = xplenty.terminate_job(job['id'])
      assert_equal(200, response.status)
    end
  end

end

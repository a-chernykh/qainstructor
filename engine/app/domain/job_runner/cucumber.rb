module JobRunner

  class Cucumber < Base
    def run
      super

      if needs_selenium?
        $selenium.with do |conn|
          url, session_id = conn.get
          result = @container.exec(['bin/verify.sh', @job.token, url, session_id])
          result[2] == 0
        end
      else
        result = @container.exec(['bin/verify.sh', @job.token])
        result[2] == 0
      end
    end

    private

    def needs_selenium?
      Dir[File.join(directory, '**/*.rb')].each do |f|
        return true if File.read(f).include?('@browser')
      end
      false
    end
  end

end

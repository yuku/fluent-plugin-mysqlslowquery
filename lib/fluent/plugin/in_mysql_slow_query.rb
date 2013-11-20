#
# in_mysql_slow_query
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require "myslog"

module Fluent

class MySQLSlowQueryInput < TailInput
  Plugin.register_input('mysql_slow_query', self)

  def configure_parser(conf)
    @parser = MySlog.new
  end

  def receive_lines(lines)
    es = MultiEventStream.new
    @parser.divide(lines).each do |record|
      begin
        record = @parser.parse_record(record)
        if time = record.delete(:date)
          time = time.to_i
        else
          time = Time.now.to_i
        end
        es.add(time, record)
      rescue
        $log.warn record, :error=>$!.to_s
        $log.debug_backtrace
      end
    end

  unless es.empty?
    begin
      Engine.emit_stream(@tag, es)
    rescue
      # ignore errors. Engine shows logs and backtraces.
    end
  end # es

  end
end

end

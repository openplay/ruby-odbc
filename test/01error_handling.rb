raised = false
begin
  $c.do("select * from _nonexistent_table_odbc_test_")
rescue ODBC::Error => e
  raised = true
  raise "error message not a String" unless e.message.is_a?(String)
  raise "error message is empty" if e.message.empty?
end
raise "expected ODBC::Error to be raised" unless raised

err = ODBC.error
raise "ODBC.error should be an Array" unless err.is_a?(Array)
raise "ODBC.error should not be empty" if err.empty?
err.each do |msg|
  raise "error element not a String" unless msg.is_a?(String)
  raise "error element is empty" if msg.empty?
end

ODBC.clear_error
raise "ODBC.error should be nil after clear" unless ODBC.error.nil?

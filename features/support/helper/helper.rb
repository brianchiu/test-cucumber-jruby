def retry_method(tries, rescue_error)
	begin
		yield
	rescue rescue_error
        retry unless (tries -= 1).zero?
		raise
	end
end
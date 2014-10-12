step "it is safely evaluated" do
  begin
    send "it is evaluated"
  rescue Exception => e
    @exception = e
  end
end

step "an exception is raised" do
  expect(@exception).to be_an(Exception)
end

step "the exception message is :message" do |message|
  expect(@exception.message.to_s).to eq(message)
end

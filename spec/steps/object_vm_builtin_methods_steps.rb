step 'the following source:' do |source|
  @source = source
end

step 'it is evaluated' do
  @result = Huia.eval(@source).invoke
end

step 'the result is :value' do |value|
  send 'the result is:', value
end

step 'the result is:' do |value|
  expect(@result.huia_send('inspect').value).to eq(value)
end

step 'the result includes :value' do |value|
  expect(@result.huia_send('inspect').value).to include(value)
end

step "the result doesn't include :value" do |value|
  expect(@result.huia_send('inspect').value).not_to include(value)
end

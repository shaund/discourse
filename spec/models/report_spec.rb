# require 'spec_helper'

# describe Report do


#   describe 'visits report' do
#     let(:report) { Report.find('visits', cache: false) }

#     context "no visits" do
#       it "returns an empty report" do
#         report.data.should be_blank
#       end
#     end

#     context "with visits" do
#       let(:user) { Fabricate(:user) }

#       before do
#         user.user_visits.create(visited_at: 1.day.ago)
#         user.user_visits.create(visited_at: 2.days.ago)
#       end

#       it "returns a report with data" do
#         report.data.should be_present
#       end
#     end
#   end

#   [:signup, :topic, :post, :flag].each do |arg|
#     describe "#{arg} report" do
#       pluralized = arg.to_s.pluralize

#       let(:report) { Report.find(pluralized, cache: false) }

#       context "no #{pluralized}" do
#         it 'returns an empty report' do
#           report.data.should be_blank
#         end
#       end

#       context "with #{pluralized}" do
#         before do
#           fabricator = (arg == :signup ? :user : arg)
#           Fabricate(fabricator, created_at: 25.hours.ago)
#           Fabricate(fabricator, created_at: 1.hours.ago)
#           Fabricate(fabricator, created_at: 1.hours.ago)
#         end

#         it 'returns correct data' do
#           report.data[0][:y].should == 1
#           report.data[1][:y].should == 2
#         end
#       end
#     end
#   end

#   describe 'users by trust level report' do
#     let(:report) { Report.find('users_by_trust_level', cache: false) }

#     context "no users" do
#       it "returns an empty report" do
#         report.data.should be_blank
#       end
#     end

#     context "with users at different trust levels" do
#       before do
#         3.times { Fabricate(:user, trust_level: TrustLevel.levels[:new]) }
#         2.times { Fabricate(:user, trust_level: TrustLevel.levels[:regular]) }
#         Fabricate(:user, trust_level: TrustLevel.levels[:moderator])
#       end

#       it "returns a report with data" do
#         report.data.should be_present
#         report.data.find {|d| d[:x] == TrustLevel.levels[:new]} [:y].should == 3
#         report.data.find {|d| d[:x] == TrustLevel.levels[:regular]}[:y].should == 2
#         report.data.find {|d| d[:x] == TrustLevel.levels[:moderator]}[:y].should == 1
#       end
#     end
#   end

#   describe '#fetch' do
#     context 'signups' do
#       let(:report) { Report.find('signups', cache: true) }

#       context 'no data' do
#         context 'cache miss' do
#           before do
#             $redis.expects(:exists).with('signups:data').returns(false)
#           end

#           it 'should cache an empty data set' do
#             $redis.expects(:setex).with('signups:data', Report.cache_expiry, "")
#             report.data.should be_blank
#           end
#         end

#         context 'cache hit' do
#           before do
#             $redis.expects(:exists).with('signups:data').returns(true)
#           end

#           it 'returns the cached empty report' do
#             User.expects(:count_by_signup_date).never
#             $redis.expects(:setex).never
#             $redis.expects(:get).with('signups:data').returns('')
#             report.data.should be_blank
#           end
#         end
#       end

#       context 'with data' do
#         before do
#           Fabricate(:user, created_at: 25.hours.ago)
#           Fabricate(:user, created_at: 1.hour.ago)
#           Fabricate(:user, created_at: 1.hour.ago)
#         end

#         context 'cache miss' do
#           before do
#             $redis.expects(:exists).with('signups:data').returns(false)
#           end

#           it 'should cache the data set' do
#             $redis.expects(:setex).with do |key, expiry, string|
#               string =~ /(\d)+-(\d)+-(\d)+,1/ and string =~ /(\d)+-(\d)+-(\d)+,2/
#             end
#             report()
#           end

#           it 'should return correct data' do
#             report.data[0][:y].should == 1
#             report.data[1][:y].should == 2
#           end
#         end

#         context 'cache hit' do
#           before do
#             $redis.expects(:exists).with('signups:data').returns(true)
#           end

#           it 'returns the cached data' do
#             User.expects(:count_by_signup_date).never
#             $redis.expects(:setex).never
#             $redis.expects(:get).with('signups:data').returns("#{2.days.ago.to_date.to_s},1|#{1.day.ago.to_date.to_s},2")
#             report.data[0][:y].should == 1
#             report.data[1][:y].should == 2
#           end
#         end
#       end
#     end
#   end


# end

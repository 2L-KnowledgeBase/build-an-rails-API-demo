# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# intial user
users = User.create([
	{email: 'test1@cscs.com', name: 'test1', password: '1234', admin: false},
 	{email: 'test2@cscs.com', name: 'test2', password: '1234', admin: false}
])

# intial api_endpoint
api_endpoints = ApiEndpoint.create([
	{private_name: '天眼查工商数据接口(portal hbase)', public_name: '企业工商数据接口', url: '/api/v1/company'},
	{private_name: '关联图谱接口(portal neo4j)', public_name: '企业关联图谱接口', url: '/api/v1/xxxx'}
])

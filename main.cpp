#include <iostream>
#include <boost/thread.hpp>
#include <boost/asio/serial_port.hpp> 
#include <boost/asio.hpp> 
#include <boost/bind.hpp>
#include <boost/asio.hpp>

using boost::asio::ip::tcp;
using namespace std;
using namespace boost;

int main(int argc, char* argv[])
{
	if (argc == 1)
	{
		cout << "how to use : $> testapp [hostname]" << endl;
		return 0;
	}
	boost::asio::io_service io_service;
	tcp::resolver resolver(io_service);
	//string host_name = boost::asio::ip::host_name();
	string host_name = argv[1];
	cout << host_name << endl;
	tcp::resolver::query query(host_name, "");
	tcp::resolver::iterator iter = resolver.resolve(query);
	tcp::resolver::iterator end; // End marker.
	while (iter != end)
	{
		tcp::endpoint ep = *iter++;
		std::cout << ep << std::endl;
	}
}

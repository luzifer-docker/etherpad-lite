jenkins: container test

container: 
		docker build --no-cache -t etherpad-lite .

test:
		# In case last test failed remove the old container
		docker rm -f etherpad-lite-test || true
		# Start the itpad container
		docker run --name etherpad-lite-test -d etherpad-lite
		# Wait 5s for it to settle / die
		sleep 5
		# Ensure it is not dead (Exited)
		docker ps -a | grep etherpad-lite-test | grep -v 'Exited'
		# Clean up
		docker rm -f etherpad-lite-test

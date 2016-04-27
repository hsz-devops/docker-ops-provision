DH_ID=highskillz/ovh-provision--test

TIMESTAMP=$(shell date +"%Y%m%d_%H%M%S")

build:
	docker build --no-cache --rm=true -f Dockerfile -t $(DH_ID) .
	docker images $(DH_ID)

clean:
	docker rmi $(DH_ID)

shell:
	docker run -it --rm $(DH_ID) sh

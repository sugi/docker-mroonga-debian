DISTS:=wheezy jessie
LATEST=jessie
IMAGE=sugi/mroonga

all: $(addprefix build_,$(DISTS))

clean:
	rm -rf Dockerfile

$(addprefix build_,$(DISTS)):
	perl -npe 's/__DIST__/$(subst build_,,$@)/g' < Dockerfile.in > Dockerfile
	docker build --pull --no-cache -t $(IMAGE):$(subst build_,,$@) .
	docker tag $(IMAGE):$(subst build_,,$@) \
		$(IMAGE):$(subst build_,,$@)_`docker run --rm $(IMAGE):$(subst build_,,$@) apt-cache policy mysql-server-mroonga | perl -ne '/Installed: (\S+)/ and print $$1'`
	test "$(subst build_,,$@)" = "$(LATEST)" && docker tag -f $(IMAGE):$(subst build_,,$@) $(IMAGE):latest

.PHONY : clean build all

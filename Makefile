DISTS:=wheezy jessie
LATEST=jessie
IMAGE=sugi/mroonga

all: $(addprefix build_,$(DISTS))

clean:
	rm -rf Dockerfile

$(addprefix build_,$(DISTS)):
	perl -npe 's/__DIST__/$(subst build_,,$@)/g' < Dockerfile.in > Dockerfile
	docker build -t $(IMAGE):$(subst build_,,$@) .
	docker tag $(IMAGE):$(subst build_,,$@) \
		$(IMAGE):$(subst build_,,$@)_`docker run --rm $(IMAGE):$(subst build_,,$@) apt-cache policy mysql-server-mroonga | perl -ne '/Installed: (\S+)/ and print $$1'`
	test "$(IMAGE)" = "$(LATEST)" && docker tag $(IMAGE):$(subst build_,,$@) $(IMAGE):latest || true

.PHONY : clean build all

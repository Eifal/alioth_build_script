## SETUP ENVIRONMENT UBUNTU 22.04

```sh
wget https://raw.githubusercontent.com/Eifal/alioth_build_script/main/setup_env.sh -O setup_env.sh && chmod +x setup_env.sh && ./setup_env.sh
```

## CLONE DT

```sh
wget -O clone_dt.sh https://raw.githubusercontent.com/Eifal/alioth_build_script/main/clone_dt.sh && chmod +x clone_dt.sh
```

## CRAVE BUILD

```sh
crave run --no-patch -- "curl https://raw.githubusercontent.com/Eifal/alioth_build_script/main/nitro.sh | bash"
```

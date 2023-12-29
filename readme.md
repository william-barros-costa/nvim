# Install

1. Configure the ssh tunnel
```bash
curl -o ~/.ssh/gitkey https://raw.githubusercontent.com/william-barros-costa/ansible/master/.ssh/id_ed25519
chmod 600 ~/.ssh/gitkey
ssh -T git@github.com
```

2. Run the following script
```bash
cd ~/.config
git clone git@github.com:william-barros-costa/nvim.git
nvim .
```

3. Use Netrw to go to .config/nvim/lua/kane/packer.lua
4. Run `:so`
5. Run `:PackerInstall`

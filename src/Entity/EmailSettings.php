<?php

namespace App\Entity;

use App\Repository\EmailSettingsRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=EmailSettingsRepository::class)
 */
class EmailSettings
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $server;

    /**
     * @ORM\Column(type="string", length=30, nullable=true)
     */
    private $securityProtocol;

    /**
     * @ORM\Column(type="integer")
     */
    private $port;

    /**
     * @ORM\Column(type="integer")
     */
    private $type;

    /**
     * @ORM\ManyToOne(targetEntity=EmailAccount::class, inversedBy="emailSettings")
     * @ORM\JoinColumn(nullable=false)
     */
    private $emailAccount;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getServer(): ?string
    {
        return $this->server;
    }

    public function setServer(string $server): self
    {
        $this->server = $server;

        return $this;
    }

    public function getSecurityProtocol(): ?string
    {
        return $this->securityProtocol;
    }

    public function setSecurityProtocol(?string $securityProtocol): self
    {
        $this->securityProtocol = $securityProtocol;

        return $this;
    }

    public function getPort(): ?int
    {
        return $this->port;
    }

    public function setPort(int $port): self
    {
        $this->port = $port;

        return $this;
    }

    public function getType(): ?int
    {
        return $this->type;
    }

    public function setType(int $type): self
    {
        $this->type = $type;

        return $this;
    }

    public function getEmailAccount(): ?EmailAccount
    {
        return $this->emailAccount;
    }

    public function setEmailAccount(?EmailAccount $emailAccount): self
    {
        $this->emailAccount = $emailAccount;

        return $this;
    }
}

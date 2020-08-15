<?php

namespace App\Entity;

use App\Repository\EmailAccountRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=EmailAccountRepository::class)
 */
class EmailAccount
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
    private $name;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $email;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $password;

    /**
     * @ORM\OneToMany(targetEntity=EmailSettings::class, mappedBy="emailAccount", orphanRemoval=true)
     */
    private $emailSettings;

    public function __construct()
    {
        $this->emailSettings = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    /**
     * @return Collection|EmailSettings[]
     */
    public function getEmailSettings(): Collection
    {
        return $this->emailSettings;
    }

    public function addEmailSetting(EmailSettings $emailSetting): self
    {
        if (!$this->emailSettings->contains($emailSetting)) {
            $this->emailSettings[] = $emailSetting;
            $emailSetting->setEmailAccount($this);
        }

        return $this;
    }

    public function removeEmailSetting(EmailSettings $emailSetting): self
    {
        if ($this->emailSettings->contains($emailSetting)) {
            $this->emailSettings->removeElement($emailSetting);
            // set the owning side to null (unless already changed)
            if ($emailSetting->getEmailAccount() === $this) {
                $emailSetting->setEmailAccount(null);
            }
        }

        return $this;
    }
}

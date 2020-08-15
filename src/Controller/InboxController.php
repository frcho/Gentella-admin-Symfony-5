<?php

namespace App\Controller;

use Doctrine\ORM\EntityManagerInterface;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use Symfony\Component\Routing\Annotation\Route;

class InboxController extends BaseController
{
    /**
     * @var EntityManagerInterface
     */
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    /**
     * @Route("/admin/inbox",name="app_admin_inbox")
     * @IsGranted("ROLE_ADMIN")
     */
    public function inbox()
    {
        // $blogPosts = $this->inboxRepository->findAll();
        return $this->render("admin/mail/inbox.html.twig", ["inbox" => "1"]);
    }
    /**
     * @Route("/admin/inboxSetup",name="app_admin_inbox_setup")
     * @IsGranted("ROLE_ADMIN")
     */
    public function setup()
    {
        // $blogPosts = $this->inboxRepository->findAll();
        return $this->render("admin/mail/setup.html.twig");
    }
}

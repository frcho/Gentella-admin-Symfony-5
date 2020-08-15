<?php

namespace App\Form;

use App\Entity\EmailSettings;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class EmailSettingsType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('server')
            ->add('securityProtocol')
            ->add('port')
            ->add('type')
            ->add('emailAccount')
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => EmailSettings::class,
        ]);
    }
}

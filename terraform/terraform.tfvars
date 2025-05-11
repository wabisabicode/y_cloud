virtual_machines = {
    "vm-1" = {
      vm_name      = "example-debian-11" # Имя ВМ
      vm_desc      = "Описание для инженеров. Его видно только здесь" # Описание
      vm_cpu       = 2 # Кол-во ядер процессора
      ram          = 2 # Оперативная память в ГБ
      disk         = 20 # Объём диска в ГБ
      disk_name    = "debian11disk" # Название диска
      template     = "fbnv5siitn6rh0pegkcs" # ID образа ОС для использования
    },
    "vm-2" = {
      vm_name      = "example-debian-11-2" # Имя ВМ
      vm_desc      = "Описание для инженеров. Его видно только здесь"
      vm_cpu       = 2 # Кол-во ядер процессора
      ram          = 2 # Оперативная память в ГБ
      disk         = 20 # Объём диска в ГБ
      disk_name    = "debian11-2disk" # Название диска
      template     = "fbnv5siitn6rh0pegkcs" # ID образа ОС для использования
    }
    "vm-3" = {
      vm_name      = "example-debian-11-3" # Имя ВМ
      vm_desc      = "Описание для инженеров. Его видно только здесь"
      vm_cpu       = 2 # Кол-во ядер процессора
      ram          = 2 # Оперативная память в ГБ
      disk         = 20 # Объём диска в ГБ
      disk_name    = "debian11-3disk" # Название диска
      template     = "fbnv5siitn6rh0pegkcs" # ID образа ОС для использования
    }
}
